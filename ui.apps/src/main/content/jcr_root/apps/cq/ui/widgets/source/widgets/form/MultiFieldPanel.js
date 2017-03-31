CQ.form.MultiFieldPanel = CQ.Ext.extend(CQ.Ext.Panel, {
    panelValue: '',
 
    /**
     * @constructor
     * Creates a new MultiFieldPanel.
     * @param {Object} config The config object
     */
    constructor: function(config){
        config = config || {};
        if (!config.layout) {
            config.layout = 'form';
            config.padding = '10px';
        }
        CQ.form.MultiFieldPanel.superclass.constructor.call(this, config);
    },
 
    initComponent: function() {
        CQ.form.MultiFieldPanel.superclass.initComponent.call(this);
 
        this.panelValue = new CQ.Ext.form.Hidden({
            name: this.name
        });
 
        this.add(this.panelValue);
 
        var dialog = this.findParentByType('dialog');
 
        dialog.on('beforesubmit', function(){
            var value = this.getValue();
 
            if (value){
                this.panelValue.setValue(value);
            }
        },this);
    },
 
    getValue: function() {
        var pData = {};
 
        this.items.each(function(i){
            if(i.xtype === "label" || i.xtype === "hidden" || !i.hasOwnProperty("key")){
                return;
            }
 
            pData[i.key] = i.getValue();
        });
 
        return $.isEmptyObject(pData) ? "" : JSON.stringify(pData);
    },
 
    setValue: function(value) {
        this.panelValue.setValue(value);
 
        var pData = JSON.parse(value);
 
        this.items.each(function(i){
            if(i.xtype === "label" || i.xtype === "hidden" || !i.hasOwnProperty("key")){
                return;
            }
 
            if(!pData[i.key]){
                return;
            }
 
            i.setValue(pData[i.key]);
        });
    },
 
    validate: function(){
        return true;
    },
 
    getName: function(){
        return this.name;
    }
});
 
CQ.Ext.reg("multifieldpanel", CQ.form.MultiFieldPanel);  