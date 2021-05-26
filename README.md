# RingBuffer Challenge
> Requirements:
> - Initialize a ring buffer.
> - Implement `.push(item)`
> - Implement `.pop`

## Installation
```shell
git clone git@github.com:AudTheCodeWitch/ringbuffer.git
cd ringbuffer
```

## Usage
1. Run `bundle install`
2. Run the tests with `rspec`

## Aud's Notes
The ring buffer was a totally new data structure to me and really fun to learn about! 
[Wikipedia](https://en.wikipedia.org/wiki/Circular_buffer) has a decent run-down of how it works. The graphics are 
especially helpful for envisioning how a linear object (array) could be configured in a circular manner.

This exercise was completed using TDD and was a first pass. I'm confident a code review with my peers would reveal
several opportunities for improvement. Specific areas I would ask for feedback include:
- Naming, especially `@next` and `@last`
- Test organization. I'm not reusing `subject` as much as I'd like, indicating there is probably a good way to refactor 
these tests
- Test structure. `instance_variable_set` isn't ideal, but I used it for the sake of time to create my individual test
cases. I was also trying to limit the test's dependency on `#push` and `#pop`.
- Am I missing any edge cases?

## Potential Next Steps
1. Solicit feedback/code reviews and implement changes
2. Strengthen tests
3. Update documentation
4. Package as a gem!
