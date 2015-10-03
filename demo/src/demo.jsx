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

var It = React.createClass({
	getInitialState: function () {
		return { result: null };
	},
	ev: function (e) {
		e.preventDefault();

		var tree = esprima.parse(this.props.source);
		jinter.processLiterals(tree);
		jinter.processVars(tree);

		var resultRaw = jinter.ev(tree, jinter.EMPTY);

		var result = resultRaw ?
			resultRaw.toString() :
			'undefined';

		this.setState({ result: result });
	},
	rawHljs: function (source) {
		var highlight = hljs.highlight('javascript', source, false);
		return { __html: highlight.value };
	},
	render: function () {
		return <li onClick={this.ev}>
			<div className="it text">{this.props.text}</div>
			<pre
				className="hljs source"
				dangerouslySetInnerHTML={this.rawHljs(this.props.source)}
			/>
			<pre
				className="hljs source result"
			>{this.state.result || "click to eval"}
			</pre>
		</li>;
	}
});

React.render(<Demo describes={window.snippets} />, document.getElementById('container'));