'use strict';

var It = window.It;

var Describe = React.createClass({
	getInitialState: function () {
		return { visible: false };
	},
	toggle: function (e) {
		e.preventDefault();
		this.setState({ visible: !this.state.visible });
	},
	render: function () {
		if (this.state.visible) {
			function createIt(text, source, index) {
				return <It text={text} source={source} key={index} />;
			}

			var items = Object.keys(this.props.its).map(function (it, index) {
				return createIt(it, this.props.its[it], index);
			}, this);

			return <div>
				<div
					className="describe"
					onClick={this.toggle}
				>{this.props.text}</div>
				<ul>{items}</ul>
			</div>;
		} else {
			return <div>
				<div
					className="describe"
					onClick={this.toggle}
				>{this.props.text}</div>
			</div>;
		}
	}
});

window.jinterDemo = window.jinterDemo || {};
window.jinterDemo.Describe = Describe;