## cb_math_eval callback

!!! Warning
    Certain formulation can cause unexpected behaviour. As examples:
    * division by zero
    * division by negative number, example: *48/-7*
    * using text or char except for callback for operand
    * using another operator (*<*, *>*, *=*,etc)

* Supported operator is (*+*, *-*, ***, */* )
* Arguments can't start and end with operator (*+*, *-*, ***, */* )
* Two operator after another will create error
* Priority for operator is still working, which mean the multiplication and division will be executed first then addition and substraction
    * Parentheses (*(*, *)*) can't be used to change operator priority.
* Integer division method will be used for division.
* Callback can't received float number

| Argument | Result |
|----------|--------|
| 4        | 4      |
| 1+2      | 3      |
| 1-2      | -1     |
| $(max_pkeys)-$(max_registrations) | 0 |
| 2*3      | 6      |
| 0*4      | 0      |
| 4/2      | 2      |
| 10/3     | 3      |
| 47/7     | 6      |
| 0/4      | 0      |
| 1+3*4    | 13     |
| 1-10/5   | -1     |
| 109/10/4 | 2      |
