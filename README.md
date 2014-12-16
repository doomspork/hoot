```
           -------
  ._____. ( Hoot! )
  { O,o }  -y-----
  (____(\
   ="="=
```

Hoot is the language [Orwell](orwell.io) speaks, use it to specify rules and their outcomes.

## Installation

Add this line to your application's Gemfile:

    gem 'hoot', github: 'doomspork/hoot'

## Context

Hoot comprises a grammar, parser, and simple runtime.  Resolving variables, both local and shared, is handle by a `Context` object, function lookups are also handled by the `Context`.  Any Ruby object that implements these three methods can serve as a `Context`:

+ `#local(name)`
+ `#shared(name)`
+ `#function(name)`

Here is an example that defines the functions `ECHO` and `LEN` and backs variables using hashes:

```ruby
class Context

  attr_reader :locals, :shared

  def initialize(locals, shared)
    @locals = locals
    @shared = shared
  end

  def local(name)
    locals[name]
  end

  def shared(name)
    shared[name]
  end

  def function(name)
    case name
    when 'ECHO'
      proc { |str| puts str }
    when 'LEN'
      proc { |str| str.length }
    end
  end
end
```

## Usage

```ruby
Hoot.run(code, context)
```

## Contributing

Contributions are always welcome!  Please make use of [Issues](https://github.com/doomspork/hoot/issues) and [Pull Requests](https://github.com/doomspork/hoot/pulls), all code should have test coverage.

## Author/Contact

Hoot is written and maintained by [@doomspork](github.com/doomspork).

## License

Mole is made available under the [MIT](http://opensource.org/licenses/MIT) License.
