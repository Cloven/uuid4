uuid4
=====

an erlang UUID4 library, MIT licensed.

Usage
-----

```erlang
MyBinaryUUID = uuid4:uuid4().
```

Notes
-----

1.  There are several other erlang uuid libraries, but this one is explicitly MIT licensed, and only implements uuid4 (the 'random number' version).
2.  [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt) is one weird document.  Pour one out for Apollo Domain/OS!
3.  This library takes about 19 nanoseconds to create each UUID on your standard 2014 laptop.  Should be plenty fast enough for most needs.
4.  crypto:get_bytes() is used instead of crypto:strong_get_bytes(), because (a) who cares and (b) crypto:strong_get_bytes() can throw an exception if the entropy pool is not big enough or has been depleted.  Not that that is super likely to happen, but I don't have a need to debug that if it ever does.
