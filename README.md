# simplecov-console

A simple console output formatter for SimpleCov

### Usage

```bash
$ gem install simplecov-console
```

```ruby
SimpleCov.formatter = SimpleCov::Formatter::Console
# or
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console,
]

# Configure
SimpleCov::Formatter::Console.config({
  limit: 20, # Top 20 results, default 15 (nil for unlimited)
  order_method: ->(files) { files.sort{ |a,b| a.covered_percent <=> b.covered_percent } } # Ordering method, see SimpleCov API document for more informations
})
```

Example output:
```
COVERAGE:  82.34% -- 2345/2848 lines in 111 files

showing top 15 of 69 files
+----------+--------------------------------------------+-------+--------+---------------------------------------------+
| coverage | file                                       | lines | missed | missing                                     |
+----------+--------------------------------------------+-------+--------+---------------------------------------------+
|  22.73%  | lib/bixby/api/websocket_server.rb          | 22    | 17     | 11, 14, 17-18, 20-22, 24, 28-30, 32, 36-... |
|  30.77%  | app/models/role.rb                         | 13    | 9      | 28-34, 36-37                                |
|  32.14%  | lib/bixby/modules/metrics/rescan.rb        | 28    | 19     | 19-23, 27-31, 33-37, 39-41, 43              |
|  42.86%  | lib/archie/mail.rb                         | 14    | 8      | 6-8, 12-15, 22                              |
|  44.00%  | lib/archie/controller.rb                   | 50    | 28     | 18-21, 23, 27-30, 32, 38-40, 44-45, 48-4... |
|  44.44%  | app/models/metric_info.rb                  | 9     | 5      | 38-40, 42, 44                               |
|  46.15%  | lib/bixby/modules/notifier.rb              | 13    | 7      | 13-14, 27-28, 38-40                         |
|  46.15%  | lib/archie/otp/controller.rb               | 26    | 14     | 15-18, 21, 26-27, 31, 33-34, 36-38, 41      |
|  46.88%  | app/controllers/rest/models/hosts_contr... | 32    | 17     | 7, 19-22, 24, 28-30, 32, 36-38, 42-44, 48   |
|  47.83%  | lib/bixby/hooks.rb                         | 46    | 24     | 54, 68-70, 72-74, 84-86, 88-90, 104, 111... |
|  48.28%  | app/controllers/rest/models/checks_cont... | 29    | 15     | 5, 7-8, 10, 13, 34, 38-40, 44-45, 47, 49... |
|  48.44%  | app/controllers/application_controller.rb  | 64    | 33     | 19, 35-37, 57, 59-64, 67, 88, 92, 107, 1... |
|  50.00%  | app/views/models/repo.rb                   | 12    | 6      | 10, 12-13, 16-17, 20                        |
|  54.55%  | lib/ext/sidekiq_logging.rb                 | 11    | 5      | 9, 15-17, 19                                |
|  60.00%  | app/views/models/check_template.rb         | 10    | 4      | 10-13                                       |
+----------+--------------------------------------------+-------+--------+---------------------------------------------+
42 file(s) with 100% coverage not shown
```


### Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2014 Chetan Sarva. See LICENSE.txt for
further details.
