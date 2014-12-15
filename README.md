# Hoot

```
           -------
  ._____. ( Hoot! )
  { O,o }  -y-----
  (____(\
   ="="=
```

Hoot is the language [Orwell](orwell.io) uses to define rules with a set of conditions and outcomes.

## Installation

Add this line to your application's Gemfile:

	gem 'hoot', github: 'doomspork/hoot'

## Context

Hoot is just a grammar, parser, and a simple runtime.  Evaluating variable values, both local and shared, is handled through the `Context`.  The `Context` is responsible for providing a lookup for actions.  A `Context` can be any Ruby object that implements these three methods:

+ `#local(String)`
+ `#shared(String)`
+ `#function(String)`

Here is an example `Context` which uses hashes to back the variable stores and defines two functions: `ECHO` and `LEN`:

```ruby
class Context
  attr_reader :locals, shared
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

Contributions of any kind are always welcome.  Please make use of [Issues](https://github.com/doomspork//issues) and [Pull Requests](https://github.com/doomspork/hoot/pulls), all code should have test coverage.

## Author/Contact

Hoot is written and maintained by [@doomspork](github.com/doomspork).

## License

Mole is made available under the [MIT](http://opensource.org/licenses/MIT) License.


