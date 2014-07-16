# @cjsx

window.Irradiated.Components.TramTracker = React.createClass
  propTypes:
    view: React.PropTypes.object.isRequired
    data: React.PropTypes.array.isRequired

  render: ->
    console.log @props.data
    <div className="TramTracker">
      <header className="Card__header">
        { @_renderNextTram() }
      </header>
      <table className="Table">
        <thead className="Table__head">
          <td>Heading To</td>
          <td>Arriving In</td>
        </thead>
        <tbody className="Table__body">
          { @props.data.slice(1).map(@_renderTimetable) }
        </tbody>
      </table>
    </div>

  _renderNextTram: ->
    nextTram = @props.data[0]
    <table className="DisplayTable">
      <tr>
        <td className="DisplayTable__item">
          <span className="TramTracker__badge">{ @props.view.options.routeId }</span>
          <div className="DisplayTable__item__value">
            in { Moment(nextTram.arrivalTime).fromNow(true) }
          </div>
          <div className="DisplayTable__item__label">{ nextTram.destination }</div>
        </td>
      </tr>
    </table>

  _renderTimetable: (data, index) ->
    <tr className="Table__row" key={ index }>
      <td>{ data.destination }</td>
      <td>{ Moment(data.arrivalTime).fromNow(true) }</td>
    </tr>

