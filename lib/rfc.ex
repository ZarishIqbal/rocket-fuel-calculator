defmodule NASAFuelCalculator do
  @moduledoc """
  This is a Flight Fuel Consumption Calculator module for a mission
  """
  @constants %{
    :launch => %{:a => 0.042, :b => 33},
    :land => %{:a => 0.033, :b => 42}
  }

  @doc """
  Calculate fuel consumption of a flight routes given `mass` and `flight routes`.maybe_improper_list(
  The function grabs the `head` of the list and passes the tail recursively. The mass of the fuel in subsequent steps is added in each step while calculating the fuel.
  Base case occurs when the list is empty, it returns 0.

  In case of invalid arguments, {:error, "Invalid Arguments"} is returned

  Returns `total_fuel`

  ## Examples
  iex> NASAFuelCalculator.calculate_routes_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])

  51898

  """

  @spec calculate_routes_fuel(number, list) :: non_neg_integer()
  def calculate_routes_fuel(mass, list_of_routes)
      when not is_integer(mass) or not is_list(list_of_routes) do
    {:error, "Invalid Arguments"}
  end

  def calculate_routes_fuel(_, []) do
    0
  end

  def calculate_routes_fuel(mass, list_of_routes) do
    if list_of_routes == [], do: 0
    [current_step | subsequent_steps] = list_of_routes
    {directive, gravity} = current_step

    subsequent_mass = calculate_routes_fuel(mass, subsequent_steps)

    subsequent_mass + calculate_fuel(mass + subsequent_mass, gravity, directive)
  end

  @doc """
  Calculate fuel consumption of a single flight route given `mass`, `gravity` and `flight_directive`

  Returns `total_fuel`

  ## Examples
  iex> NASAFuelCalculator.calculate_fuel(28801, 9.807, :land)

  9278

  iex> NASAFuelCalculator.calculate_fuel(28801, 9.807, :launch)

  19772
  """

  @spec calculate_fuel(number, number, :land | :launch) :: non_neg_integer()

  def calculate_fuel(mass, gravity, directive) do
    calculated_fuel = base_fuel(mass, gravity, directive)

    if calculated_fuel <= 0,
      do: 0,
      else: calculated_fuel + calculate_fuel(calculated_fuel, gravity, directive)
  end

  defp base_fuel(fuel, gravity, directive) do
    constants = @constants[directive]
    fuel = fuel * gravity * constants.a - constants.b
    floor(fuel)
  end
end
