class App.FullPhoto extends Spine.Model
  @configure 'FullPhoto', 'photo_url_large'

  @extend Spine.Model.Ajax

  @url: "/api/v1/photos"

  constructor: ->
    @class = "GaragePhoto"
    super

  facebook_share_summary: => encodeURI("Come join #{this.username} and be apart of Auxotic: The Next Generation Car Community.")
  facebook_share_image: => encodeURI("#{this.photo_url_large}.jpg")
  facebook_full_url: => encodeURI("http://#{Domain}/photos/#{this.id}")
  facebook_title: => encodeURI("#{this.username}'s #{this.garage.year} #{this.garage.model_name}")
  twitter_tweet: => encodeURI("Checkout #{this.username}'s #{this.garage.year} #{this.garage.model_name} on @auxotic #{this.facebook_full_url()}")

