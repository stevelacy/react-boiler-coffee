React = require 'react'
DOM = React.DOM
{div} = DOM

module.exports = React.createClass
  componentWillMount: ->
    console.log @

  render: ->

    DOM.div
      className: 'helper'
