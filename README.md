# Mockingjay

[![Code Climate](https://codeclimate.com/github/baweaver/mockingjay.png)](https://codeclimate.com/github/baweaver/mockingjay)

Fixtures are a hastle to keep up to date, especially with an active development of the data that's being returned. Worst case, you can't predict when a little thing is going to change and it breaks all your fixtures!

Why not let the data define fixtures for you, and generate away?

Mockingjay aims to bridge that gap for you.

## Usage

### Mockingjay::Serialize

Takes in a Ruby hash and turns it into a set of default generators based on types. Default rulesets are configured in Rules to control this behavior. As most scenarios will have a json response sent directly, you can pass in either a ruby hash or JSON string.

```ruby
hash = {
  a: 1, 
  b: {
    c: [1,2,3], 
    d: 'foo!', 
    e: { f: 1.0 } 
  }
}

json = '{"a": 1, "b": { "c": [1,2,3], "d": 'foo!', "e": { "f": 1.0 }}}'

Mockingjay::Serialize.new(hash)
Mockingjay::Serialize.new(json)
```

...both would render the json:

```ruby
'{
  "a": { "Generator.fixnum":"(1..100)" },
  "b": {
    "c": [
      { "Generator.fixnum":"(1..100)" },
      { "Generator.fixnum":"(1..100)" },
      { "Generator.fixnum":"(1..100)" }
      ],
    "d": { "Generator.string":"Lorem.word" },
    "e": {
      "f": { "Generator.float":"(1..100)" }
    }
  }
}'
```

### Mockingjay::Deserialize

Takes a Generator Template in as a JSON string and turns it into a ruby hash by calling Generator hooks in the string.

```ruby
'{
  "a": { "Generator.fixnum":"(1..100)" },
  "b": {
    "c": [
      { "Generator.fixnum":"(1..100)" },
      { "Generator.fixnum":"(1..100)" },
      { "Generator.fixnum":"(1..100)" }
      ],
    "d": { "Generator.string":"Lorem.word" },
    "e": {
      "f": { "Generator.float":"(1..100)" }
    }
  }
}'
```

Looks in Generators for matching rules, or returns that the generator is unknown.

(TODO: Date Support)


### Mockingjay::Generators

Methods for converting generator hooks into ruby values

This Generator:

```ruby
{ "Generator.fixnum":"(1..100)" }
```

Would call this method in Mockingjay::Generators:

```ruby
def fixnum(str_range)
  a, b = *str_range.split(/...?/).map(&:to_i)
  b ? rand(a..b).to_i : rand(a).to_i
end
```

with the arg string "(1..100)"


(Granted I need to fix ranges on that)

### Mockingjay::Rules

Default Rules for serializing types of data into Generators

When Deserialize hits a value that is a fixnum, it looks in Mockingjay::Rules for a function with the same name:

```ruby
def fixnum
  {'Generator.fixnum' => '(1..100)'}
end
```

...and returns the hash as the generator to insert into the JSON template being created.

# Notes

This was done in about a 4 hour time frame, and still has a fair amount of work to be done. It is most certainly alpha software. Be careful.

See Issues for work I'm planning to do.
