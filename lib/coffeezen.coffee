coffee = require( "coffee-script" ).compile

compile = ( oEditor ) ->
    return unless oEditor.getCursorScopes().indexOf( "source.js" ) isnt -1
    unless ( sSelection = oEditor.getSelectedText() )
        oEditor.selectLine()
        sSelection = oEditor.getSelectedText()
        iTabLevel = oEditor.indentLevelForLine sSelection
    oRange = oEditor.getSelectedBufferRange()
    sTab = oEditor.getTabText()

    try
        sCompiledSelection = coffee sSelection, bare: yes
    catch oError
        return atom.confirm
            message: "CoffeeScript Check - Oops !"
            detailedMessage: oError.message

    # TODO : automatic indentation for sCompiledSelection

    oEditor.setTextInBufferRange oRange, sCompiledSelection

module.exports =
    activate: ->
        atom.workspaceView.command "coffeezen:compile", ".editor", ->
            compile atom.workspaceView.getActivePaneItem()
