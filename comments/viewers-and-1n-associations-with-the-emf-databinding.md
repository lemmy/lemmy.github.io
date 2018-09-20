Comment by Ed Merks | 2008/01/28 at 12:35:09
-------------

Cool! You’d be more than welcome to create a data binding section in EMF’s recipes wiki. Be sure to include your name with the contribution so you can take credit for it. A label provider that delegates to EMF’s item providers makes a lot of sense, i.e., AdapterFactoryObservableMapLabelProvider. Feel free to open a bugzilla feature request for that. We could prototype something together to see how it works out…

Comment by Boris Bokowski | 2008/01/28 at 16:11:48
-------------

To customize the labels (e.g. let them display a calculated value), you can subclass ObservableMapLabelProvider. One of the snippets (Snippet007ColorLabelProvider) shows an example of this. Also, we have a patch attached to https://bugs.eclipse.org/bugs/show_bug.cgi?id=196785 for derived attributes (e.g., when the person’s address is a separate object containing street, city, …).

Comment by markus | 2008/01/28 at 16:26:14
-------------

Hi Boris,
doing the custom labels in the LabelProvider might lead to the problem of missed notifications to the values on which the custom label is based. To avoid this, I’d prefer adding the custom value in the EMF layer and handling the recalculation there. Unfortunately method don’t show up as EStructuralFeature. Surely this only makes sense if the custom label fits into the model.


Comment by Chandresh Gandhi | 2010/02/18 at 12:41:11
-------------

Hi Markus,

Currently I’m putting hands on EMF Databinding Framework and caught your example / use-case same as my requirement.
I’d given it try to display EList (Address), a Person object holds. But It only shows “Street – PERSON_ADDRESS__STREET ” attribute.

Can you please point me out where did I make mistake. I’d expected “All address attributes for a person” to be show in table.
Following is my code.


    public class EMFDatabindingView extends ViewPart {
    
    private TableViewer viewer;
    
    public EMFDatabindingView() {
    // TODO Auto-generated constructor stub
    }
        
    @Override
    public void createPartControl(Composite parent) {
    
    viewer = new TableViewer(parent, SWT.FULL_SELECTION);
    viewer.getTable().setHeaderVisible(true);
    
    ObservableListContentProvider provider = new ObservableListContentProvider();
    viewer.setContentProvider(provider);
    
    IObservableSet knownElements = provider.getKnownElements();
    IObservableMap[] observeMaps = EMFObservables.observeMaps(knownElements,
    new EStructuralFeature[] {
    EmfdatabindingPackage.Literals.PERSON_ADDRESS__STREET,
    EmfdatabindingPackage.Literals.PERSON_ADDRESS__CITY,
    EmfdatabindingPackage.Literals.PERSON_ADDRESS__COUNTRY,
    EmfdatabindingPackage.Literals.PERSON_ADDRESS__ZIP
    });
    ObservableMapLabelProvider labelProvider = new ObservableMapLabelProvider(observeMaps);
    viewer.setLabelProvider(labelProvider);
    
    viewer.setInput(EMFObservables.observeList(Realm.getDefault(), getPerson(),
    EmfdatabindingPackage.Literals.PERSON__ADDRESSES));
    }
    
    private Person getPerson(){
    
    Person person = EmfdatabindingFactory.eINSTANCE.createPerson();
    person.setName(” Chandresh Gandhi “);
    
    PersonAddress address = EmfdatabindingFactory.eINSTANCE.createPersonAddress();
    address.setStreet(” Kamdar Street “);
    address.setCity(” Dhoraji – Rajkot”);
    address.setCountry(“India”);
    address.setZip(“360 410″);
    
    person.getAddresses().add(address);
    
    return person;
    }
    
    @Override
    public void setFocus()
    {
    
    }
    }

