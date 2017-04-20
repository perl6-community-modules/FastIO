unit class IO::Path::Fast;
use nqp;

has     $!cwd;
has Str $!path;

method !SET-SELF ($!path, $!cwd) {
    $!path || die "Must specify something as a path: did you mean '.' for "
                  ~ "the current directory?";
    (    nqp::isne_i(nqp::index($!path, "\0"), -1)
      || nqp::isne_i(nqp::index($!CWD,  "\0"), -1)
    ) && X::IO::Null.new.throw;
    self
}
method new (Str $path               ) { self.bless!SET-SELF($path, $*CWD) }
method new (Str $path, ::?CLASS $cwd) { self.bless!SET-SELF($path, $cwd ) }
method new (Str $path, Str      $cwd) { self.bless!SET-SELF($path, $cwd ) }
