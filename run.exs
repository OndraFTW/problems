
import Problems

defmodule RunHelper do
  def list_write([]), do: IO.write("\n")
  def list_write([head]), do: IO.write(head<>"\n")
  def list_write([head|tail]) do
    IO.write(head<>",")
    list_write(tail)
  end

  def list_of_lists_write([]), do: IO.write("\n")
  def list_of_lists_write([head]), do: list_write(head)
  def list_of_lists_write([head|tail]) do
    list_write(head)
    list_of_lists_write(tail)
  end

  def list_of_list_of_lists_write([]), do: IO.write("\n")
  def list_of_list_of_lists_write([head]), do: list_of_lists_write(head)
  def list_of_list_of_lists_write([head|tail]) do
    list_of_lists_write(head)
    list_of_list_of_lists_write(tail)
  end

end

#a=group234(["aldo","beat","carla","david","evi","flip","gary","hugo","ida"])
a=group(["aldo","beat","carla","david","evi"], [2,3])
RunHelper.list_of_list_of_lists_write(a)
