sub setData()
    ' We keep json around just as a reference,
    ' but ideally everything should be going through one of the interfaces
    datum = m.top.json

    m.top.id = datum.id
    m.top.name = datum.name
    m.top.type = datum.type

    if datum.CollectionType = invalid then
        m.top.CollectionType = datum.type
    else
        m.top.CollectionType = datum.CollectionType
    end if

    ' Set appropriate Images for Wide and Tall based on type

    if datum.type = "CollectionFolder" OR datum.type = "UserView" then
        params = { "Tag" : datum.ImageTags.Primary, "maxHeight" : 261, "maxWidth" : 464 }
        m.top.thumbnailURL = ImageURL(datum.id, "Primary", params)
        m.top.widePosterUrl = m.top.thumbnailURL

    else if datum.type = "Episode" then
        imgParams = { "AddPlayedIndicator": datum.UserData.Played }

        if datum.UserData.PlayedPercentage <> invalid then
            imgParams.Append({ "PercentPlayed": datum.UserData.PlayedPercentage })
        end if

        imgParams.Append({ "maxHeight": 261 })
        imgParams.Append({ "maxWidth": 464 })

        if datum.ImageTags.Primary <> invalid then
            param = { "Tag" : datum.ImageTags.Primary }
            imgParams.Append(param)
        end if

        m.top.thumbnailURL = ImageURL(datum.id, "Primary", imgParams)

        ' Add Wide Poster  (Series Backdrop)
        if datum.ParentThumbImageTag <> invalid then
            imgParams["Tag"] = datum.ParentThumbImageTag
            m.top.widePosterUrl = ImageURL(datum.ParentThumbItemId, "Thumb", imgParams)
        else if datum.ParentBackdropImageTags <> invalid then
            imgParams["Tag"] = datum.ParentBackdropImageTags[0]
            m.top.widePosterUrl = ImageURL(datum.ParentBackdropItemId, "Backdrop", imgParams)
        else if datum.ImageTags.Primary <> invalid then
            imgParams["Tag"] = datum.SeriesPrimaryImageTag
            m.top.widePosterUrl = ImageURL(datum.id, "Primary", imgParams)
        end if

    else if datum.type = "Series" then
        imgParams = { "maxHeight": 261 }
        imgParams.Append({ "maxWidth": 464 })

        if datum.UserData.UnplayedItemCount > 0 then
          imgParams["UnplayedCount"] = datum.UserData.UnplayedItemCount
        end if

        if datum.ImageTags.Primary <> invalid then
          imgParams["Tag"] = datum.ImageTags.Primary
        end if

        m.top.posterURL = ImageURL(datum.id, "Primary", imgParams)

        ' Add Wide Poster  (Series Backdrop)
        if datum.ImageTags <> invalid and datum.imageTags.Thumb <> invalid then
            imgParams["Tag"] = datum.imageTags.Thumb
            m.top.widePosterUrl = ImageURL(datum.Id, "Thumb", imgParams)
        else if datum.BackdropImageTags <> invalid then
            imgParams["Tag"] = datum.BackdropImageTags[0]
            m.top.widePosterUrl = ImageURL(datum.Id, "Backdrop", imgParams)
        end if

    else if datum.type = "Movie" then
        imgParams = { AddPlayedIndicator: datum.UserData.Played }

        if datum.UserData.PlayedPercentage <> invalid then
            imgParams.Append({ "PercentPlayed": datum.UserData.PlayedPercentage })
        end if

        imgParams.Append({ "maxHeight": 261 })
        imgParams.Append({ "maxWidth": 175 })

        if datum.ImageTags.Primary <> invalid then
            param = { "Tag" : datum.ImageTags.Primary }
            imgParams.Append(param)
        end if

        m.top.posterURL = ImageURL(datum.id, "Primary", imgParams)

        ' For wide image, use backdrop
        imgParams["maxWidth"] = 464

        if datum.ImageTags <> invalid and datum.imageTags.Thumb <> invalid then
            imgParams["Tag"] = datum.imageTags.Thumb
            m.top.thumbnailUrl = ImageURL(datum.Id, "Thumb", imgParams)
        else if datum.BackdropImageTags[0] <> invalid then
            imgParams["Tag"] = datum.BackdropImageTags[0]
            m.top.thumbnailUrl = ImageURL(datum.id, "Backdrop", imgParams)
        end if

    else if datum.type = "MusicAlbum" then
        params = { "Tag" : datum.ImageTags.Primary, "maxHeight" : 261, "maxWidth" : 261 }
        m.top.thumbnailURL = ImageURL(datum.id, "Primary", params)
        m.top.widePosterUrl = m.top.thumbnailURL
        m.top.posterUrl = m.top.thumbnailURL

    else if datum.type = "TvChannel" OR datum.type = "UserView" then
      m.top.widePosterUrl = "pkg:/images/baseline_live_tv_white_48dp.png"

    end if

end sub