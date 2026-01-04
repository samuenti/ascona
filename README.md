# Ascona

Use SVG icons in Ruby.

Ascona loads your SVG icons into memory at boot. Fast lookups, simple helper.

## Installation

```ruby
gem 'ascona'
```

Then `bundle install`.

## Setup

Create `config/initializers/ascona.rb`:

```ruby
Ascona.configure do |config|
  config.icon_path = "app/assets/icons"
  config.default_library = :lucide
end
```

## Folder Structure

Each SVG library should be stored in separate folders (create custom libraries by adding a new folder):

```
app/assets/icons/
  lucide/
    star.svg
    arrow-left.svg
  heroicons/
    check.svg
```

The name of the folder will be used as the library name.

## Usage

```erb
<%= icon "star" %>
<%= icon "star", class: "w-5 h-5" %>
<%= icon "star", library: :heroicons %>
```

Attributes are added directly to the `<svg>` tag.

## Non-Rails

Include the helper manually:

```ruby
include Ascona::Helper
```

Call `Ascona.load` before using icons.

## License

MIT
