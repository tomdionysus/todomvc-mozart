class App.PageSelectControl extends Mozart.Control
  templateName: 'app/templates/controls/page_select_control'
  pages: []

  init: =>
    super()
    @targetObj = Mozart._getPath(@target) if @target?
    @targetObj = @parent unless @targetObj?

  afterRender: =>
    unless @collectionView?
      @collectionView = @targetObj.childView(@for)
      @bindToCollection()

    @selectEl = @element.find("##{@id}-select")
    @pageChanged()

  pageTotalChanged: =>
    @pages = (i for i in [1..@collectionView.pageTotal])
    @redraw()

  pageChanged: =>
    @selectEl.val(@collectionView.pageCurrent+1)

  pageSelected: (el, data) =>
    @collectionView.set('pageCurrent',@selectEl.val()-1)

  release: =>
    @unbindFromCollection()
    super()

  bindToCollection: =>
    @collectionView.bind('change:pageTotal', @pageTotalChanged)

  unbindFromCollection: =>
    @collectionView.unbind('change:pageTotal', @pageTotalChanged)
