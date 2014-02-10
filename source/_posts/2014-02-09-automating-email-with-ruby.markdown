---
layout: post
title: "Automating Email with Ruby"
date: 2014-02-09 20:28
comments: true
categories: 
---
Last Friday was the kind of day where I dropped into a Pry repl in order to bang out an automation script.

The challenge was: automate the retrival of specific emails that contained receipts, wrangle them into sane data structures, and dump them into a spreadsheet with both daily totals and an absolute total.

An example email looked like this:
```
 Receipt #9999999999999


 County:Example, FL      Date: 2014-1-27 

 Name:Jill Doe
 Credit Card #XXXXXXXXXXXX9999
 Authorization code:999999

 No.of Pages viewed:3
 Total Amount: $ 3.00

 Thank you for visiting http://www.example.com  
```

First step was to build an email parser for this format.  I tried to keep it tolerant of future changes to the email generation scheme.

The general steps involved are:
1. Split the body linewise
2. Create a method for each piece of content to extract.
3. From the collection of lines, grep for the line with appropriate unique text.
4. Then in that line, use a regex to find the specific portion of data.

The full code for that module is listed below.

```ruby
module Email
    class Parser
      attr_accessor :email, :content
      def initialize(email)
        @raw_content = email.to_s
        @content = @raw_content.split("\n").map(&:strip)
      end

      def receipt
        content.grep(/receipt/i).first[/\d+/]
      end

      def county_line
        @county_line ||= content.grep(/county.*date/i)[0]
                                .split(/\W{3,}/)
                                .map { |i| Hash[*i.split(':').map(&:strip)] }
      end

      def county
        county_line.first["County"]
      end

      def date
        county_line[1]["Date"]
      end

      def name
        array = content.grep(/name/i).first.split(':')[1]
      end

      def credit_card_number
        content.grep(/credit card/i).first[/#.*$/]
      end

      def authorization_code
        content.grep(/authorization code/i).first.split(':')[1]
      end

      def pages_viewed
        begin
          content.grep(/pages viewed/i).first[/\d+/].strip
        rescue NoMethodError => e
          warn "#{e.message} for #{content.inspect}"
        end
      end

      def total_amount
        content.grep(/total amount/i).first
                                     .split(':')[1]
                                     .gsub(/\$/, '')
                                     .strip
      end

      def website
        content.grep(/visiting http/i).first[/http.*$/i]
      end

      def all
        ParsingPresenter.new(
          county: county,
          date: date,
          name: name,
          credit_card_number: credit_card_number,
          authorization_code: authorization_code,
          pages_viewed: pages_viewed,
          total_amount: total_amount,
          website: website,
          receipt: receipt
        )
      end
      def self.all(msg)
        ps = new(msg)
        ps.all
      end

    end

    ParsingPresenter = Class.new(OpenStruct)
```

With that in order, I set about using the awesome `ruby-gmail` gem for retrieving said emails. Note: after completing this project, I learned of a continuation of the `ruby-gmail` gem called `gmail`.  All the code in these examples is specific to the older incarnation of the gem.

`ruby-gmail` has a simple interface for retrieving messages between date ranges.  So I setup a specific Gmail filter for emails from a certain sender that included the text 'receipt'.

There's nothing too fancy in this code, but it's important to set `@gmail.peek = true` so that programatically viewed emails aren't marked 'read'.  Also of note is the use of Dotenv for setting secret values without risking them in a git repo.


```
 class Retriever

      USER = ENV['GMAIL_USER']
      PASSWORD = ENV['GMAIL_PASSWORD']
      LABEL = 'Receipts'

      attr_accessor :user, :password, :gmail, :messages
      def initialize(user=USER, password=PASSWORD)
        @user = user
        @password = password
        @gmail = Gmail.new(@user, @password)
        @gmail.peek = true
      end

      def message_count_in_range(start_date, end_date)
        #dates as '2010-02-10'
        gmail.inbox
             .count(:after => start_date, :before => end_date)
      end

      def emails_in_range(start_date, end_date, label=LABEL)
        #dates as '2010-02-10'
        gmail.mailbox(label)
             .emails(:after => start_date, :before => end_date)
      end

      def message_presenters_in_range(start_date, end_date)
        msgs = emails_in_range(start_date, end_date)
        @messages = msgs.map do |msg|
          Presenter.present(msg)
        end
      end

    end

    class Presenter
      attr_accessor :email
      def initialize(msg)
        @email = msg
      end

      def body
        email.body
      end

      def date
        email.date.to_date
      end

      def date_string
        date.to_s
      end

      def self.present(msg)
        presenter = new(msg)
        Message.new(date: presenter.date_string, body: presenter.body)
      end
    end

    Message = Class.new(OpenStruct)
```

The last task in building this tool was dumping the data to a CSV with totals by date as well as a grand total. The process is simple, pass in a collection of messages and iterate through them by date, add a subtotal per date, then add a final row with grand total.

I like to break out rows into their own methods when possible.  In fact, were I to rewrite this code, the message row would have its own method to clean up the inner loop of `messages_by_date()`.  Another trick that helped for testing was to not generate a file on the filesystem.  `CSV` takes either an `open` or a `generate` method.  With `generate` it will pass the complete csv file out as the return value!  

```
class CSVBuilder
    attr_accessor :messages, :csv
    def initialize(messages)
      @messages = messages
    end

    def create
      @csv = CSV.generate do |csv|
        csv << header
        csv << empty_row
        uniq_dates.each do |date|
          messages_by_date(date).each do |msg|
            csv << [msg.date, msg.receipt, msg.authorization_code, msg.pages_viewed, msg.name, msg.credit_card_number, msg.total_amount]
          end
          csv << sum_totals_row(messages_by_date(date), "Subtotal for #{date}")
        end
        csv << empty_row
        csv << sum_totals_row(messages, "Total Amount")
      end
    end

    def header
      ['Date',
       'Receipt #',
       'Authorization Code',
       'Pages Viewed',
       'Name',
       'Credit Card #',
       'Total Amount']
    end

    def empty_row
      Array.new(header.count)
    end

    def messages_by_date(date)
      messages.select { |m| m.date == date }
    end

    def uniq_dates
      messages.map(&:date).uniq.sort
    end

    def sum_totals_row(msgs, label)
      rawsum = msgs.map { |m| m.total_amount.to_f }.inject(:+)
      sum = sprintf( "%.2f", rawsum )
      sum_row_padding = Array.new(header.count)
      sum_row = [ sum_row_padding, label, sum ].flatten
    end
  end
```

I'm also quite proud of the variable name `rawsum` because it's rawsome to design code that will save a couple hours every two weeks.

With a good ecosystem of libraries, it's only a couple hours of work to write a re-usable tool that saves significant amounts of time. Hooray :).
