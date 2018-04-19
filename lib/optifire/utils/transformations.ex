defmodule Optifire.Transformations do
  @moduledoc """
  ImageMagic transformations module.
  """

  def apply(cmd, file, args) do
    args     = [file | String.split(args, " ")]
    program  = to_string(cmd)

    ensure_executable_exists!(program)

    case System.cmd(program, args_list(args), stderr_to_stdout: true) do
      {return, 0} ->
        {:ok, return}
      {error_message, _exit_code} ->
        {:error, error_message}
    end
  end

  defp args_list(args) when is_list(args), do: args
  defp args_list(args), do: ~w(#{args})

  defp ensure_executable_exists!(program) do
    unless System.find_executable(program) do
      raise Arc.MissingExecutableError, message: program
    end
  end
end
