class App.CollectionPageControl extends Mozart.Control
  templateName: 'app/templates/controls/collection_page_control'

  init: ->
    super()
    @bind 'change:pageCurrent', @redraw
    @bind 'change:pageTotal', @redraw

  beforeRender: =>
    @pages = []
    start = Math.max(0, Math.min(@pageCurrent-4, @pageTotal-9))
    end = Math.min(@pageTotal-1,start+8)
    pos = start
    while pos<=end
      txt = pos+1
      @pages.push({number:pos, text:txt, current:pos==@pageCurrent})
      pos++
    if @pages.length == 0
      @pages = [{number:1, text:1, current:true}]

    @previousDisabled = @pageCurrent<=0
    @nextDisabled = @pageCurrent>=@pageTotal-1
    @dispCurrentPage = @pageCurrent+1

  previous: =>
    @set('pageCurrent', @pageCurrent-1) unless @previousDisabled

  next: =>
    @set('pageCurrent', @pageCurrent+1) unless @nextDisabled 

  setPage: (e) =>
    @set('pageCurrent', e.data('page'))