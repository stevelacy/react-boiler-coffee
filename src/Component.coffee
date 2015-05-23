React = require 'react'
browserVersion = require 'browser-version'

DOM = React.DOM

module.exports = React.createClass
  componentWillMount: ->

    console.log browserVersion()

  render: ->

    DOM.div
      className: 'box'
