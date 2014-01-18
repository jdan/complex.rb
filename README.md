## complex.rb

I am writing several ruby classes to supplement the material taught in my
MA 234 - *Complex Variables and their Applications* course.

```ruby
$ irb -r ./complexnum.rb
2.0.0-p247 :001 > a = ComplexNum.new 2, -3
 => 2 - 3i
2.0.0-p247 :002 > b = ComplexNum.new 1, 1
 => 1 + i
2.0.0-p247 :003 > a + b
 => 3 - 2i
2.0.0-p247 :004 > a * b
 => 5 - i
2.0.0-p247 :005 > (a**17).imag
 => 2474152797
```
