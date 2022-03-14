defmodule RFCTest do
  use ExUnit.Case
  doctest NASAFuelCalculator

  test "Required Fuel for Apollo 11" do
    assert NASAFuelCalculator.calculate_routes_fuel(28801, [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 9.807}
           ]) ==
             51898
  end

  test "Required Fuel for Mission on Mars" do
    assert NASAFuelCalculator.calculate_routes_fuel(14606, [
             {:launch, 9.807},
             {:land, 3.711},
             {:launch, 3.711},
             {:land, 9.807}
           ]) == 33388
  end

  test "Required Fuel for Passenger ship" do
    assert NASAFuelCalculator.calculate_routes_fuel(75432, [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 3.711},
             {:launch, 3.711},
             {:land, 9.807}
           ]) == 212_161
  end

  test "Required Fuel for a single landing on Earth" do
    assert NASAFuelCalculator.calculate_fuel(28801, 9.807, :land) == 13447
  end

  test "Required Fuel for a single launching from Earth" do
    assert NASAFuelCalculator.calculate_fuel(28801, 9.807, :launch) == 19772
  end

  test "Invalid arguments passed" do
    assert NASAFuelCalculator.calculate_routes_fuel("", [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 3.711},
             {:launch, 3.711},
             {:land, 9.807}
           ]) === {:error, "Invalid Arguments"}
  end
end
