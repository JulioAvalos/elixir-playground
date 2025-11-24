# Example usage:

# library = %{
#   library: "Central Library",
#   shelves: [
#     %{
#       id: 1,
#       category: "Fantasy",
#       books: [
#         %{id: 101, title: "Book A", available: true},
#         %{id: 102, title: "Book B", available: false},
#         %{id: 103, title: "Book C", available: false}
#       ]
#     },
#     %{
#       id: 2,
#       category: "Science",
#       books: [
#         %{id: 201, title: "Book D", available: true},
#         %{id: 202, title: "Book E", available: false}
#       ]
#     }
#   ]
# }

# library = Library.add_book(library, 1, "Book G")
# library = Library.add_book(library, 2, "Book F")
# library = Library.mark_available(library, 102)
# library = Library.mark_available(library, 103)
# library = Library.mark_unavailable(library, 201)

defmodule Library do

  def add_book(library, shelf_id, title) do
    max_id = library.shelves
      |> Enum.flat_map(fn shelf -> shelf.books end)
      |> Enum.map(fn book -> book.id end)
      |> Enum.max(fn -> 0 end)

    next_id = max_id + 1

    updated_shelves =
      Enum.map(library.shelves, fn shelf ->
        if shelf.id === shelf_id do
          new_book = %{id: next_id, title: title, available: true}
          %{shelf | books: shelf.books ++ [new_book]}
        else
          shelf
        end
      end)

    %{library | shelves: updated_shelves}
  end

  def mark_available(library, book_id) do
    updated_shelves =
      Enum.map(library.shelves, fn shelf ->
        updated_books =
          Enum.map(shelf.books, fn book ->
            if book.id === book_id do
              %{book | available: true}
            else
              book
            end
          end)
        %{shelf | books: updated_books}
      end)

    %{library | shelves: updated_shelves}
  end

  # optional: more points!
  def mark_unavailable(library, book_id) do
    updated_shelves =
      Enum.map(library.shelves, fn shelf ->
        updated_books =
          Enum.map(shelf.books, fn book ->
            if book.id === book_id do
              %{book | available: false}
            else
              book
            end
          end)
        %{shelf | books: updated_books}
      end)

    %{library | shelves: updated_shelves}
  end

end
