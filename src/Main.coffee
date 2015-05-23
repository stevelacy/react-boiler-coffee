React = require 'react'

DOM = React.DOM

module.exports = React.createClass
  componentWillMount: ->
    console.log @

  render: ->

    DOM.div
      className: 'helper'
