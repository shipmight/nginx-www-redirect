# nginx-www-redirect

Very simple Docker image, which performs a request from www to non-www domain.

Note: the image should handle any domain, example.com is used in this documentation as an example.

## How it works

Any request with the header `Host` header beginning with `www.` returns a 301 redirect to the non-www domain.

![Diagram of redirecting to non-www domain](diagram-301.svg)

When the `Host` header does not begin with `www.`, a `404` response is returned.

![Diagram of responding to an already non-www domain](diagram-404.svg)

## Why

If you need to redirect visitors from a www-domain to the non-www equivalent, and have an architecture where deploying a new container which accepts traffic from www-domains is easy, you can use this image to achieve the redirect.

## Requirements

This image runs with as low as 10MB of memory and some CPU cycles.

## Testing locally

Build the image:

```bash
docker build -t nginx-www-redirect:dev .
```

Start it:

```bash
docker run --rm -p 8080:80 nginx-www-redirect:dev
```

Make a request and observe returned headers:

```shell
$ curl -v -H 'Host: www.example.com' http://127.0.0.1:8080
< HTTP/1.1 301 Moved Permanently
< Location: http://asd.com/
...
```

For automation purposes there's a script `bash test.sh`, which is used in the CI.

## For Shipmight users

Note: domain redirects (including www to non-www) will be an out-of-the-box feature in Shipmight. In the meantime, you can use this image.
