angular.module('todoApp').directive 'todoList', ->
  restrict: 'E'
  scope:
    todos: '='
  templateUrl: 'templates/todo-list.html'
  controller: TodoListController

class TodoListController
  constructor: ($scope, @todoStorage) ->
    $scope.ctrl = @

  saveTodo: (todo, index) =>
    @todoStorage.put todo, index
