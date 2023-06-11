defmodule Tutorials.Structs.Expense do
  alias Tutorials.Structs.Expense

  defstruct(
    title:"",
    date:nil,
    amount: 0,
    store:""
  )

  @type t :: %Expense{
    title:String.t(),
    date:Date.t() | nil,
    amount:number(),
    store: String.t()
  }

  @spec sample :: [t()]
  def sample do
    [
    %Expense{title:"grocery",date:~D[2023-02-01],amount:300},
    %Expense{title:"movie",date:~D[2023-02-23],amount:700},
    %Expense{title:"games",date:~D[2023-01-12],amount:500},
    %Expense{title:"laptop",date:~D[2023-01-34],amount:1300},
    ]
  end


  @spec total([t]) :: number()
  def total(expenses)do
    expenses
    |> Enum.reduce(0,fn expense, acc -> expense.amount + acc end)

  end

  @spec sort_by_date([t()]) :: [t()]
  def sort_by_date(expense) do
    expense
    |> Enum.sort_by(& &1.date)
  end

  @spec add_expense(t) :: [t()]
  def add_expense(%Expense{} = expense) do
    [expense | sample()]
  end

  def update_amount(title,amount)do
    [item] = Enum.filter(sample(), fn %{title: expense_title} -> expense_title = title end)
    new_item %{item | amount: amount}
    [new_item | sample() |> List.delete(item)]
  end

  @user ["coco" , "cece","louis", "Chiko"]

  def authenticate(user) when user in @users, do: {:ok, "authorized"}
  def authenticate(_), do:{:error,"unauthorized"}

  def verify_password(user,_password) when user in @users, do:{:ok , " password verified"}
  def verify_password(_user,_password), do:{:error,"wrong password"}

  def login(user,password) do
    with {:ok,_auth_msg} <- authenticate(user)
    {:ok,_msg} <- verify_password(user,password) do
      {:ok,"#{user} logged in successfully"}
    else
      {:error,msg} -> {:error,msg}
    end
  end
end
