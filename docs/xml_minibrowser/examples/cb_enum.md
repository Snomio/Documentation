## enum callback

**Usage Hint**

* Arguments is an integer type. It mean there is no decimal point for arguments.
* Arguments is separated by colon.
* If only one argument given, the argument will transferred as end value. The loop will start from one to end value with step from one (or minus one if end value is smaller than one).
* If two arguments give, the first argument will transferred to start value and the second one to end value. If the start value is bigger than end value the loop will have step value from one. In other case the loop will have step value from minus one.
* If three arguments given, the arguments will transferred to start, end and step value respectively. The sign of step value will be modified based on the comparison of start and end value.
* If Step value is bigger than the difference between start and end value, the callback will only return start value.
* Be careful for the syntax when using another callback as argument. In this example you have to write following: `$(enum:$(max_registrations))` or `$(enum:$(set:vol_speaker_mic))`

| Argument | Result |
|----------|--------|
| 5        | `|1|2|3|4|5|` |
| -5       | `|1|0|-1|-2|-3|-4|-5|` |
| 1:8      | `|1|2|3|4|5|6|7|8|` |
| 1:-3     | `|1|0|-1|-2|-3|` |
| 4:-1     | `|4|3|2|1|0|-1|` |
| 1:8:2    | `|1|3|5|7|` |
| 1:-8:-2  | `|1|-1|-3|-5|-7|` |
| 1:-8:2   | `|1|-1|-3|-5|-7|` |
| -8:1:-2  | `|-8|-6|-4|-2|0|` |
| -8:1:3   | `|-8|-5|-2|-1|` |
| -8:1:11  | `|-8|` |
| $(max_registrations)| `|1|2|3|4|5|6|7|8|9|10|11|12|` |
