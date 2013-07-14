Garage = App.Garage

class App.Garages extends Spine.Controller

  events:
    'click .item img' :  'openPhoto'
    'click .item a'   :  'navigateTag'
    'click .item'     :  'setActive'

  constructor: ->
    super
    Garage.bind "refresh change", =>
      @render()
      @hideLoading()

  hideLoading: =>
    $("#loading").hide()
    $(".feed").show()

  render: =>
    @html @view('garages/index')()
    @garageItem = {}
    for garage in @sortedGarages().reverse()
      @garageItem[garage.id] = new App.GarageItem(garage) unless $("##{garage.id}_garage").length

  sortedGarages: =>
    _.sortBy Garage.all(), (obj) ->
        obj.updated_at

  navigateTag: (e) =>
    if e.target.href && e.target.href.match(/\/tags\//)
      e.preventDefault()
      @navigate('/tags', $(e.currentTarget).attr("href").replace(/\/tags\//,""))
    e.stopPropagation()

  openPhoto: (e) ->
    if $(e.target).closest("a").attr("href").match(/\/photos\//)
      e.preventDefault()
      @navigate('/photos', $(e.target).closest("a").attr("href").replace(/\/photos\//,""))
    e.stopPropagation()

  setActive: (e) ->
    $target = $(e.currentTarget)
    garageItem = @garageItem
    unless $target.hasClass("active")
      $(".item.active").each ->
        garageItem[parseInt($(this).attr 'id')].removeActive()
      @garageItem[parseInt($target.attr 'id')].renderActive()
      #$("html, body").animate
        #scrollTop: $target.offset().top - 300
      #, 100

class App.GarageItem extends Spine.Controller

  constructor: (garage) ->
    @garage = garage
    @add()

  id: =>
    @garage.id

  add: =>
    $(".feed").append @view('garages/garage')(@garage)
    @container = $("##{@garage.id}_garage")
    @convertToTimeAgo()

  update: =>
    @container.after @view('garages/garage')(@garage)
    @container.remove()
    @container = $("##{@garage.id}_garage")
    @addCommentsIfActive()
    @convertToTimeAgo()

  convertToTimeAgo: =>
    @container.find("time.timeago").timeago()

  addCommentsIfActive: =>
    new App.Comments(el: @container.find(".comments"), object: @garage) if @garage.active

  renderActive: =>
    @garage.setPhotoLimit(20)
    @garage.setActive()
    @update()
    @container.addClass "active"

  removeActive: =>
    @garage.setPhotoLimit(5)
    @garage.setActive(false)
    @update()
    @container.removeClass "active"
