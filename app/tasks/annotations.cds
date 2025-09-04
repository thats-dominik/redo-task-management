using TaskService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Tasks with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'assignee_ID',
                Value : assignee_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'dueAt',
                Value : dueAt,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : '{i18n>GeneralInformation}',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversation}',
            ID : 'i18nConversation',
            Target : 'comments/@UI.LineItem#i18nConversation',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : creator.name,
            Label : '{i18n>Creator}',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Description}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgency}',
        },
        {
            $Type : 'UI.DataField',
            Value : assignee.name,
            Label : '{i18n>Assignee}',
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : creator.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
    UI.DeleteHidden : { $edmJson: { $Not: { $Path: '/TaskService.EntityContainer/UiConfig/canDelete' } } },
    UI.UpdateHidden : { $edmJson: { $Not: { $Path: '/TaskService.EntityContainer/UiConfig/canUpdate' } } },
    
    
);

annotate service.Tasks with @Capabilities.DeleteRestrictions : {
  Deletable : { $edmJson : { $Path : '/TaskService.EntityContainer/UiConfig/canDelete' } }
};


annotate service.Tasks with {
    creator @(
        Core.Computed : true,
        Common.Text : creator.ID,
        Common.Text.@UI.TextArrangement : #TextOnly,
        )
};

annotate service.Tasks with {
    assignee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Users',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : assignee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'username',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'firstName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'lastName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
    }
};

annotate service.Tasks with {
    status @(
        Common.Label : '{i18n>Status}',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Tasks with {
    urgency @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.descr,
    )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Urgency with {
    code @Common.Text : descr
};

annotate service.Tasks.comments with @(
    UI.LineItem #i18nConversation : [
        {
            $Type : 'UI.DataField',
            Value : author,
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Message}',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
        },
    ]
);

