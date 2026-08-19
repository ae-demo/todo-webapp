// Todo webapp — two screens: task list, task form

screen TaskList "Signed-in user views, filters, sorts, and manages their own tasks"
  navbar "TodoApp"
  row
    heading "My Tasks"
    right
    search "Search tasks…"
    select "Sort: Due date"
    button "New task" primary -> TaskForm
  tabs "All (12) | Active (8) | Completed (4)"
  table "Task | Due date | Status | Actions" -> TaskForm
    row "Buy groceries | Today | Overdue | Edit · Complete · Delete"
    row "Finish quarterly report | Fri | Active | Edit · Complete · Delete"
    row "Renew passport | — | Active | Edit · Complete · Delete"
    row "Book dentist appointment | Aug 10 | Completed | Edit · Delete"

screen TaskForm "User creates a new task or edits an existing one"
  navbar "TodoApp"
  breadcrumb "My Tasks / Task"
  heading "New Task"
  input "Title — e.g. Buy groceries"
  input "Due date (optional)"
  checkbox "Mark as completed"
  row
    right
    button "Cancel" -> TaskList
    button "Save task" primary -> TaskList
