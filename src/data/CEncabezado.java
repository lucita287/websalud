package data;

public class CEncabezado {
	private CArea areaidarea;
	private CMultimedia multimediaidmultimedia;
	
	public CEncabezado(CArea areaidarea, CMultimedia multimediaidmultimedia) {
		super();
		this.areaidarea = areaidarea;
		this.multimediaidmultimedia = multimediaidmultimedia;
	}
	/**
	 * @return the areaidarea
	 */
	public CArea getAreaidarea() {
		return areaidarea;
	}
	/**
	 * @param areaidarea the areaidarea to set
	 */
	public void setAreaidarea(CArea areaidarea) {
		this.areaidarea = areaidarea;
	}
	/**
	 * @return the multimediaidmultimedia
	 */
	public CMultimedia getMultimediaidmultimedia() {
		return multimediaidmultimedia;
	}
	/**
	 * @param multimediaidmultimedia the multimediaidmultimedia to set
	 */
	public void setMultimediaidmultimedia(CMultimedia multimediaidmultimedia) {
		this.multimediaidmultimedia = multimediaidmultimedia;
	}
	
	
	
}
