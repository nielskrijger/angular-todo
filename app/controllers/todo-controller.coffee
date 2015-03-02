angular.module('todoApp').controller 'TodoController',
  class TodoController
    list: [
      text: "learn coffescript"
      done: false
    ,
      text: "learn angular"
      done: true
    ]

    addTodo: ->
      @list.push
        text: @input
        done: false
      @input = ''

    remaining: ->
      count = 0
      for todo in @list
        count += if todo.done then 0 else 1
      count

    archive: ->
      oldList = @list
      @list = []
      for todo in oldList
        unless todo.done
          @list.push todo
