# goto.zsh
If you're like me and you maintain a hierarchical filesystem, it can be a real 
pain to get where you want to go. I know they're considered harmful, but why not 
try a `goto`?

```shell
$ cd ~/doc/programming/web/arrdem.com
$ echo $PWD
/home/reid/doc/programming/web/arrdem.com
# that's long as hell... let's fix that
$ label arrdem.com
$ cd
$ echo $PWD
/home/reid
$ goto arrdem.com
$ echo $PWD
/home/reid/doc/programming/web/arrdem.com
```

This is a relatively alpha script and could use some serious attention.

- no way to delete labels once you set them besides editing the labels file
- the labels file (~/.labels.tsv) _must_ be tab seperated
- the error messages on a missing label are useless
