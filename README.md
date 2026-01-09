# Ascona

Use SVG icons in Ruby.

Ascona loads your SVG icons into memory at boot. Fast lookups, simple helper.

## Installation

```ruby
gem 'ascona'
```

Then `bundle install`.

## Setup

Generate the initializer:

```bash
rails generate ascona:install
```

Or create `config/initializers/ascona.rb` manually:

```ruby
Ascona.configure do |config|
  config.icon_path = "app/assets/icons"
  config.default_library = :lucide
end
```

## Supported Libraries

| Library | Link |
|---------|------|
| Lucide | [lucide.dev](https://lucide.dev) |


## Downloading Icons

```bash
ascona list                          # Show available libraries
ascona download lucide               # Download all icons
ascona download heroicons --variant=outline  # Download specific variant
```

## Folder Structure

Each SVG library should be stored in separate folders (create custom libraries by adding a new folder):

```
app/assets/icons/
  lucide/
    star.svg
    arrow-left.svg
  heroicons/
    outline/
      check.svg
    solid/
      check.svg
```

The name of the folder will be used as the library name.

## Usage

```erb
<%= icon "star" %>
<%= icon "star", size: 5 %>
<%= icon "star", class: "w-5 h-5" %>
<%= icon "star", library: :heroicons, variant: :outline %>
```

The `size` option adds Tailwind classes `w-{size} h-{size}`.

## Default Size

Set a default size for all icons:

```ruby
config.default_size = 5
```

Icons without an explicit `size` will use this default.

## Variants

Some libraries have variants. Set defaults per library (for rendering only):

```ruby
config.default_variants = { heroicons: :outline }
```

Note: Some libraries have no default variant. You must specify one when downloading (`--variant=outline`) and when rendering (`variant: :outline`) unless set in config.

## Non-Rails

Include the helper manually:

```ruby
include Ascona::Helper
```

Call `Ascona.load` before using icons.

## License

MIT
