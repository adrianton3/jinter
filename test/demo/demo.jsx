'use strict';

var Demo = React.createClass({
	render: function () {
		function createList(text, its, index) {
			return <Describe text={text} its={its} key={index} />;
		}

		var items = Object.keys(this.props.describes).map(function (describe, index) {
			return createList(describe, this.props.describes[describe], index);
		}, this);

		return <ul>{items}</ul>;
	}
});

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
				<span onClick={this.toggle}>{this.props.text}</span>
				<ul>{items}</ul>
			</div>;
		} else {
			return <div>
				<span onClick={this.toggle}>{this.props.text}</span>
			</div>;
		}
	}
});

var It = React.createClass({
	render: function () {
		return <li>
			<div className="it text">{this.props.text}</div>
			<div className="source">{this.props.source}</div>
		</li>;
	}
});

React.render(<Demo describes={window.snippets} />, document.getElementById('container'));