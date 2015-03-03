angular.module('todoApp').controller 'TodoController', ($scope, todoStorage) ->
  new class TodoController
    constructor: ->
      $scope.ctrl = @
      @input = null
      @todos = todoStorage.todos
      console.log todoStorage
      console.log 'Loaded TodoController'

    addTodo: ->
      console.log "Adding todo", @input
      if @input?
        todoStorage.insert
          text: @input
          completed: false
      @input = null

    remaining: ->
      console.log "Get remaining todos"
      count = 0
      for todo in @todos
        count += if todo.completed then 0 else 1
      count

    clearCompleted: ->
      console.log "Clear completed todos"
      todoStorage.clearCompleted()

    clearAll: ->
      todoStorage.clearAll()
