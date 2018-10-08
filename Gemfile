source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.1"
gem "active_model_serializers", "~> 0.10.0"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "jwt"
gem "pg"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.1"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.5"
  gem "rubocop", "~> 0.54.0", require: false
end

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails", "~> 4.0"
  gem "faker"
  gem "shoulda-matchers", "~> 3.1"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
