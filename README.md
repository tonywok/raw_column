# RawColumn

Let me just start out by saying that this is an edge case.

With rails 4 came support for postgresql json columns. Every now and again I find myself wanting to stuff a blob into a column. However, when I pull out the JSON, rails turns it into a hash! That's great, but I'm just going to serialize that hash into JSON. I feel like there's a "yo dawg" in there somewhere, but I don't care to explore it more.

So, yeah, here's a gem that does that for you.

We don't need no stinking serialization.

## Installation

`gem 'raw_column'`

Then `bundle install` that bad mamma jamma.

## Usage

Include the module, specify your raw columns. Like so:

```ruby
class DeathStar < ActiveRecord::Base

  include RawColumn

  raw_column :geonosian_blueprints

  def moon?
    false
  end
end
```

```ruby
  # In your controller somewhere
  respond_to :json
  def show
    @deathstar = DeathStar.find(params[:id])
    respond_with(@deathstar.raw_geonosian_blueprints)
  end
```

So there's one method: `raw_column`. All it's doing is defining a convenience method `raw_#{your_column}` that simply wraps its `before_type_cast` method in a proxy object to handle all the `as_json` wizardry.

I usually end up naming my blob column `content`, so I made that the default. If you're feeling super lazy and would like to confuse the next developer who inherits your one-a-kind codebase, you can just say `raw_column` and I'll go ahead and assume you meant `:content`. You're welcome.

## Result

On a minor scale (maybe your show method)

```
Completed 200 OK in 42ms (Views: 27.2ms | ActiveRecord: 2.6ms)

became

Completed 200 OK in 15ms (Views: 0.2ms | ActiveRecord: 3.2ms)
```

On a much larger scale (say, your index)
```
Completed 200 OK in 1257ms (Views: 854.6ms | ActiveRecord: 25.0ms)

became

Completed 200 OK in 240ms (Views: 60.1ms | ActiveRecord: 11.2ms)
```

Sure, those are contrived, but you see what I mean: In cases where you're just spitting out preformatted JSON, the (JSON -> Hash -> JSON) conversion is a waste.

## Todo

Write a test. I extracted it from an app. There are tests there, promise. Give me a minute, okay?

## Contributing

There ain't much here. That said, if it's broke, do me a solid and fix it. We can have beers or something, somewhere, sometime.

## Thanks

Created mostly while sitting on Jones' Couch. Thanks for the help. And the couch - man that thing's good.
