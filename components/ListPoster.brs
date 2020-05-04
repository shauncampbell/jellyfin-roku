sub init()
    m.poster = m.top.findNode("poster")
    m.poster.translation = [2, 0]

    m.backdrop = m.top.findNode("backdrop")
    m.backdrop.translation = [2, 0]

    m.backdrop.color = "#404040FF"

    updateSize()
end sub

sub updateSize()
    m.poster = m.top.findNode("poster")
    m.backdrop = m.top.findNode("backdrop")
    m.selectedIndicator = m.top.findNode("selectedIndicator")

    image = invalid
    if m.top.itemContent <> invalid and m.top.itemContent.image <> invalid
      image = m.top.itemContent.image
    end if

    ' If the image is invalid then show the backdrop
    ' otherwise show the image
    m.poster.visible = image <> invalid
    m.backdrop.visible = not m.poster.visible

    ' TODO - abstract this in case the parent doesnt have itemSize
    maxSize = m.top.getParent().itemSize

    ratio = 1.5
    if image <> invalid and image.width <> 0 and image.height <> 0
      ratio = image.height / image.width
    end if

    ' Get maximum working area for the poster
    posterVertSpace = int(maxSize[1]) - 15
    posterHoriSpace = int(maxSize[0])

    ' Set Poster sizes
    m.poster.width = int(maxSize[0]) - 10
    m.poster.height = m.poster.width * ratio
    m.poster.translation = [((posterHoriSpace - m.poster.width)/2), (posterVertSpace - m.poster.height) / 2]

    if m.poster.height > posterVertSpace
      ' Do a thing to shrink the image if it is too tall
    end if

    ' Set backdrop sizes
    m.backdrop.width = posterHoriSpace
    m.backdrop.height = posterVertSpace
    m.backdrop.translation = [0, 0]

    ' Depending on what is being displayed (backdrop or image) then
    ' set the selected indicator to match the width
    if image <> invalid and image.width <> 0 and image.height <> 0
        m.selectedIndicator.width = m.poster.width
        m.selectedIndicator.translation = [((posterHoriSpace - m.poster.width)/2), posterVertSpace]
    else
        m.selectedIndicator.width = m.backdrop.width
        m.selectedIndicator.translation = [0, posterVertSpace]
    end if

    ' Configure selected indicator
    m.selectedIndicator.height = 5
    m.selectedIndicator.color = "#00A4DCFF"
    m.selectedIndicator.visible = false

end sub

function itemContentChanged() as void
    m.poster = m.top.findNode("poster")
    itemData = m.top.itemContent
    m.poster.uri = itemData.posterUrl

    updateSize()
end function

function itemFocusChanged() as void
    m.selectedIndicator = m.top.findNode("selectedIndicator")
    m.selectedIndicator.visible = m.top.itemHasFocus
end function
