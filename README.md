```
           -------
  ._____. ( Hoot! )
  { O,o }  -y-----
  (____(\
   ="="=
```

Hoot is a proof-of-concept language around conditions and their outcomes.

## Installation

Add this line to your application's Gemfile:

    gem 'hoot', github: 'doomspork/hoot'

## Context

Hoot is made up of three parts: a grammar, a parser, and basic runtime.  Resolving variables and function lookup are handled by a `Context` object.  To crate a `Context` implement these methods:

+ `#local(name)`
+ `#shared(name)`
+ `#function(name)`

Here an example defines the functions `ECHO` and `LEN` and backs variables using hashes:

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
