angular.module('todoApp').controller 'TodoEditController', ($scope, $state, todoStorage) ->
  new class TodoEditController
    constructor: ->
      console.log 'Loading TodoEditController'
      $scope.ctrl = @
      $scope.todo = @todo = angular.copy(todoStorage.todos[$state.params.todoIndex])
      if not @todo?
        $state.go('todos')

    save: =>
      todoStorage.put($scope.todo, $state.params.todoIndex)
      $state.params.todoIndex
      $state.go('todos')

    cancel: ->
      $state.go('todos')
