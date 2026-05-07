---
title: Installation
---
# Installation

``` ruby
# Gemfile
group :development do
    gem 'boot64', git: 'https://github.com/CHUReimsDSN/Boot64-Rails.git'
end
```

```sh
bundle install
```

## Cibler une branche spécifique

``` ruby
# Gemfile
group :development, :test do
    gem 'boot64', git: 'https://github.com/CHUReimsDSN/Boot64-Rails.git', branch: 'nom_de_la_branche'
end
```

## Dépendances

```ruby
# Runtime depedencies
"activerecord", ">= 6.0"
```
