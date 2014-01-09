# Mockingjay

Fixtures are a hastle to keep up to date, especially with an active development of the data that's being returned. Worst case, you can't predict when a little thing is going to change and it breaks all your fixtures!

Why not let the data define fixtures for you, and generate away?

Mockingjay aims to bridge that gap for you.

## Usage

### Mockingjay::Deserialize

Takes a JSON string and turns it into a ruby hash by calling Generator hooks in the string.

```ruby
{
  "a": {
    "Generator.fixnum":"(1..100)"
  },
  "b": {
    "c": [
      {"Generator.fixnum":"(1..100)"},
      {"Generator.fixnum":"(1..100)"},
      {"Generator.fixnum":"(1..100)"}
      ],
    "d": {
      "Generator.string":"Lorem.word"
    },
    "e": {
      "f": {"Generator.float":"(1..100)"}
    }
  }
}
```

Looks in Generators for matching rules, or returns that the generator is unknown.

(TODO: Date Support)

### Mockingjay::Serialize

Takes in a Ruby hash and turns it into a set of default generators based on types. Default rulesets are configured in Rules to control this behavior

```ruby
Mockingjay::Serialize.new({a: 1, b: {c: [1,2,3], d: 'foo!', e: { f: 1.0 } } } )
```

...would render the hash:

```ruby
{
  "a": {
    "Generator.fixnum":"(1..100)"
  },
  "b": {
    "c": [
      {"Generator.fixnum":"(1..100)"},
      {"Generator.fixnum":"(1..100)"},
      {"Generator.fixnum":"(1..100)"}
      ],
    "d": {
      "Generator.string":"Lorem.word"
    },
    "e": {
      "f": {"Generator.float":"(1..100)"}
    }
  }
}
```

### Mockingjay::Generators

Methods for converting generator hooks into ruby values

```ruby
def fixnum(str_range)
  a, b = *str_range.split(/...?/).map(&:to_i)
  b ? rand(a..b).to_i : rand(a).to_i
end
```

When a fixnum hook is hit, such as:

```ruby
{"Generator.fixnum":"(1..100)"}
```

This method will be called with a string '(1..100)'

(Granted I need to fix ranges on that)

### Mockingjay::Rules

Default Rules for serializing types of data into Generators

```ruby
def fixnum
  {'Generator.fixnum' => '(1..100)'}
end
```

Whenever a fixnum is encountered in a raw hash, it will be substituted with this Generator hook by default.

# Notes

This was done in about a 4 hour time frame, and still has a fair amount of work to be done. It is most certainly alpha software. Be careful.
