"use strict"

class MainCtrl
  @$inject = ['Site','Pack','Model','ngRParams']
  constructor: (@Site,@Pack,@Model,@ngRParams)->
    @editingPack = null
    @selectedPacks = []
    @loadingPacks = false
    @loadSites()
    @loadPacks
      count: 25
      limit: ['packid'
              'title'
              'paysiteid'
              'flag_pub'
              'flag_email'
              'packdate'
              'updated_at']
      sorting:
        packdate: 'desc'
  isOverdue: (pack)=>
    !pack.flag_pub && (new Date(pack.packdate)) < (new Date)
  isSelected: (pack)=>
    @selectedPacks.indexOf(pack.packid)!=-1
  togglePack: (pack)=>
    if (id = @selectedPacks.indexOf(pack.packid)) !=-1
      @selectedPacks.splice id, 1
    else
      @selectedPacks.push pack.packid
  loadSites: =>
    @Site.get (data)=>
      @sites = data.result
  updatePage: =>
    @packData.request.page = @packData.page
    @loadPacks @packData.request
  loadPacks: (options)=>
    @loadingPacks = true
    @Pack.get @ngRParams.url(options), (data)=>
      @loadingPacks = false
      @packs = data.result
      @packData =
        total: data.total
        page: data.page
        request: options

module.exports = MainCtrl