sub init()
  m.top.itemComponentName = "ListPoster"
  m.top.content = setData()

  m.top.rowFocusAnimationStyle = "fixedFocusWrap"
  ' Disable the white box around the selected items.
  m.top.drawFocusFeedback = false

  m.top.showRowLabel = [false]

  m.top.setFocus(true)
end sub

sub updateSize()
  m.top.numRows = 1
  if m.top.itemsPerRow = invalid or m.top.itemsPerRow = 0 then
    m.top.itemsPerRow = 5
  end if

  dimensions = m.top.getScene().currentDesignResolution

  border = 75
  m.top.translation = [border, border + 100]

  itemWidth = ((dimensions["width"] - border*2) / m.top.itemsPerRow) - 20
  itemHeight = itemWidth * 1.5

  m.top.visible = true

  ' Size of the individual rows
  m.top.itemSize = [dimensions["width"] - border*2, itemHeight]
  ' Spacing between Rows
  m.top.itemSpacing = [ 0, 10]

  ' Size of items in the row
  m.top.rowItemSize = [ itemWidth, itemHeight ]
  ' Spacing between items in the row
  m.top.rowItemSpacing = [ 20, 0 ]
end sub

function setupRows()
  updateSize()

  objects = m.top.objects
  itemsPerRow = m.top.itemsPerRow

  n = objects.items.count()

  ' This tests to make sure we are at an integer number of rows
  if int(n/itemsPerRow) = n/itemsPerRow then
    m.top.numRows = n/itemsPerRow
  ' Otherwise we need an extra (not full) row for the leftovers
  else
    m.top.numRows = n/itemsPerRow + 1
  end if

  m.top.content = setData()

end function

function setData()
  data = CreateObject("roSGNode", "ContentNode")
  if m.top.objects = invalid then
    ' Return an empty node just to return something; we'll update once we have data
    return data
  end if

  objects = m.top.objects
  itemsPerRow = m.top.itemsPerRow

  for rowNum = 1 to m.top.numRows
    row = data.CreateChild("ContentNode")
    for i = 1 to itemsPerRow
      index = (rowNum - 1) * itemsPerRow + i
      if index > objects.items.count() then
        exit for
      end if
      row.appendChild(objects.items[index-1])
    end for
  end for

  return data
end function

function onKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  return false
end function
