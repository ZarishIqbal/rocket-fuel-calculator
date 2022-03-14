# Rocket Fuel Calculator

This application helps in calculating the fuel required in a NASA mission.

The application takes 2 inputs:

> - initial_mass: `integer`
> - list_of_routes: `[{directive,gravity}]`

The directive can either be `:launch` or `:land`

Depending upon the directive the fuel needed is calculated using the formula

#### `:launch`

> `mass * gravity * 0.042 - 33 rounded down`

#### `:land`

> `mass * gravity * 0.033 - 42 rounded down`

Fuel adds weight to the ship, so it requires additional fuel, until additional fuel is 0 or negative.

The fuel needed for the entire mission is to be carried from the earth right from the start, which adds more mass to the flight. So, we need to calculate the fuel needed for each step by adding the weight of fuel of all subsequent steps.

## Examples

---

**Mission Fuel**

```shell
iex> NASAFuelCalculator.calculate_routes_fuel(14606,[{:launch, 9.807},{:land, 3.711},{:launch, 3.711},{:land, 9.807}])

```

> Output: 33388

**Single Route Fuel**

```shell
iex> NASAFuelCalculator.calculate_fuel(28801, 9.807, :launch)

```

> Output: 19772
