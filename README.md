Koupler Docker
=====================================

Koupler Docker runs [Koupler](https://github.com/socialvibe/koupler) in a Docker
container. Who would've guessed.

Building
--------

Building Koupler Docker is easy. Just run `./build.sh`. This will fetch the
Koupler source from Github and build it inside a docker image.

Running
-------

Running Koupler Docker is almost as easy. First, make sure you have a file
called `aws.env` in the koupler_docker directory. It should look like this:

```
AWS_ACCESS_KEY_ID=<your aws key id>
AWS_SECRET_ACCESS_KEY=<your aws secret key>
```

Then run `./run.sh <port>` to run Koupler Docker listening on that port.

To verify that everything is working properly, you can make a post request to
Koupler. For example:

```
curl -X POST 127.0.0.1:<port>/<stream_name> -d "<partition_key>,<record>"
```

If everything is working as intended, you should see the record you sent show up
in the consumer for whichever stream you were testing with.
