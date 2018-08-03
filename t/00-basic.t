use v6;
use Test;
use File::Find::Duplicates;

plan 7;

ok find_duplicates(dirs => ['t/test-files']) ==
    (["t/test-files/empty1", "t/test-files/empty2"],
    ["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"]),
    "Basic functionality";

ok find_duplicates(dirs => ['t/test-files'], recursive => True) ==
    (["t/test-files/empty1", "t/test-files/empty2"],
     ["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],
     ["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"]),
    "Recursive search";

ok find_duplicates(dirs => ['t/test-files'], ignore_empty => True) ==
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],),
    "Ignoring empty files";

ok find_duplicates(dirs => ['t/test-files'], recursive => True, method => 'compare') ==
    (["t/test-files/empty1", "t/test-files/empty2"],
     ["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],
     ["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"]),
    "Byte comparisons";

ok find_duplicates(dirs => ['t/test-files/foo1', 't/test-files/foo2'],
                     ignore_empty => True) ==
    (["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],),
    "Multiple directory search";

ok 't/test-files'.IO.duplicates ==
    (["t/test-files/empty1", "t/test-files/empty2"],
     ["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"]),
   "IO::Path Method";

ok 't/test-files'.IO.duplicates(recursive => True, ignore_empty=>True) ==
    (["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],
     ["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"]),
    "Method with recursion";
