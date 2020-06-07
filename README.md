# Redis over HTTP

This repo contains a fork of redis that can be accessed directly by a web browser using HTTP.

Redis normally executes commands by parsing its own protocal called RESP: https://redis.io/topics/protocol

But the protocol also support "Inline Commands", which look like this:
```
GET somekey
SET somekey somevalue
```

This just so happens to be close enough to HTTP:

```
GET /somekey HTTP/1.1
```

By modifying how Redis processes requests and generated responses, we can turn RESP into HTTP.

## Development

This repo is forked from Redis 6.0, then `http-redis.patch` is applied.
Then you can build and test the code with:
```
cd src
make
./redis-server ../redis.conf
```

* To test a GET command: `curl -i localhost:6379/mykey`
* To test a SET command: `curl -iX SET "localhost:6379/mykey \"somevalue\""`
* To run administrative commands, `./redis-cli` still works since the HTTP code only affects use of the "inline" protocol.

All other supported commands can be constructed similarly.

The contents of homepage.html are accessed by the key "/", which cannot be modified.

### ACLs

I use ACLs (new in redis 6.0) to prevent anonymous users from running dangerous commands.
These ACLs can be found on line 764 of redis.conf.

## Limitations

Requests sizes are limited to 16128 bytes to simplify buffer handling since I'm not exactly an expert in C code.

Several commands have been disabled for security reasons (like obviously SHUTDOWN).
